import axios, { AxiosError } from 'axios';
import { log } from './logger';
import { CacheManager } from './cache';

// ---------------------------------------------------------------------------
// Interfaces
// ---------------------------------------------------------------------------

export interface GitHubRepo {
  name: string;
  fullName: string;
  description: string | null;
  stars: number;
  language: string | null;
  url: string;
  owner: {
    login: string;
    avatar: string;
  };
}

export interface GitHubUserActivity {
  user: {
    login: string;
    name: string | null;
    avatar: string;
    followers: number;
    following: number;
    publicRepos: number;
  };
  streak: number;
  recentActivity: Array<{
    type: string;
    repo?: string;
    created_at: string;
    payload: any;
  }>;
}

export interface DevToArticle {
  title: string;
  description: string;
  url: string;
  tags: string[];
  author: {
    name: string;
    username: string;
    profile_image: string;
  };
  published_at: string;
  positive_reactions_count: number;
  cover_image: string | null;
}

export interface StackOverflowQuestion {
  title: string;
  body: string;
  url: string;
  score: number;
  answer_count: number;
  view_count: number;
  tags: string[];
  owner: {
    name: string;
    reputation: number;
  };
  creation_date: Date;
}

export interface YouTubeVideo {
  title: string;
  description: string;
  url: string;
  thumbnail: string;
  channel: {
    name: string;
    id: string;
  };
  published_at: string;
}

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------

const BASE_URLS = {
  github: 'https://api.github.com',
  devTo: 'https://dev.to/api',
  stackoverflow: 'https://api.stackexchange.com/2.3',
  youtube: 'https://www.googleapis.com/youtube/v3',
} as const;

const DEFAULT_CACHE_TTL = 30 * 60 * 1000; // 30 minutes

// ---------------------------------------------------------------------------
// Service
// ---------------------------------------------------------------------------

export class ExternalApiService {
  private apiKeys: {
    github?: string;
    devTo?: string;
    stackoverflow?: string;
    youtube?: string;
  };

  private cache: CacheManager<any>;

  constructor() {
    this.apiKeys = {
      github: process.env.GITHUB_TOKEN,
      devTo: process.env.DEVTO_API_KEY,
      stackoverflow: process.env.STACKOVERFLOW_API_KEY,
      youtube: process.env.YOUTUBE_API_KEY,
    };

    this.cache = new CacheManager<any>({
      name: 'external-apis',
      defaultTtl: DEFAULT_CACHE_TTL,
      maxEntries: 100,
    });
  }

  // =====================================================================
  // GITHUB
  // =====================================================================

  async getGitHubTrending(
    language: string = 'javascript',
    period: 'daily' | 'weekly' = 'daily',
  ): Promise<GitHubRepo[]> {
    const cacheKey = `github_trending_${language}_${period}`;
    const cached = this.cache.get(cacheKey) as GitHubRepo[] | null;
    if (cached) return cached;

    try {
      const now = new Date();
      let dateFilter: string;

      if (period === 'weekly') {
        const weekAgo = new Date(now.getTime() - 7 * 24 * 60 * 60 * 1000);
        dateFilter = `created:>${weekAgo.toISOString().split('T')[0]}`;
      } else {
        const yesterday = new Date(now.getTime() - 24 * 60 * 60 * 1000);
        dateFilter = `created:>${yesterday.toISOString().split('T')[0]}`;
      }

      const response = await axios.get(`${BASE_URLS.github}/search/repositories`, {
        params: {
          q: `language:${language} ${dateFilter}`,
          sort: 'stars',
          order: 'desc',
          per_page: 10,
        },
        headers: this.getGitHubHeaders(),
      });

      const repos: GitHubRepo[] = response.data.items.map((repo: any) => ({
        name: repo.name,
        fullName: repo.full_name,
        description: repo.description,
        stars: repo.stargazers_count,
        language: repo.language,
        url: repo.html_url,
        owner: {
          login: repo.owner.login,
          avatar: repo.owner.avatar_url,
        },
      }));

      this.cache.set(cacheKey, repos);
      return repos;
    } catch (error) {
      const err = error as AxiosError;
      log.error('Error fetching GitHub Trending', {
        error: err.response?.data || err.message,
      });
      return [];
    }
  }

  async getGitHubUserActivity(username: string): Promise<GitHubUserActivity | null> {
    const cacheKey = `github_user_${username}`;
    const cached = this.cache.get(cacheKey) as GitHubUserActivity | null;
    if (cached) return cached;

    try {
      const [userResponse, eventsResponse] = await Promise.all([
        axios.get(`${BASE_URLS.github}/users/${username}`, {
          headers: this.getGitHubHeaders(),
        }),
        axios.get(`${BASE_URLS.github}/users/${username}/events`, {
          headers: this.getGitHubHeaders(),
          params: { per_page: 30 },
        }),
      ]);

      const user = userResponse.data;
      const events = eventsResponse.data;

      const commitStreak = this.calculateCommitStreak(events);

      const activity: GitHubUserActivity = {
        user: {
          login: user.login,
          name: user.name,
          avatar: user.avatar_url,
          followers: user.followers,
          following: user.following,
          publicRepos: user.public_repos,
        },
        streak: commitStreak,
        recentActivity: events.slice(0, 10).map((event: any) => ({
          type: event.type,
          repo: event.repo?.name,
          created_at: event.created_at,
          payload: this.extractEventPayload(event),
        })),
      };

      this.cache.set(cacheKey, activity, 10 * 60 * 1000); // 10 minutes
      return activity;
    } catch (error) {
      const err = error as AxiosError;
      log.error('Error fetching GitHub User Activity', {
        error: err.response?.data || err.message,
      });
      return null;
    }
  }

  // =====================================================================
  // DEV.TO
  // =====================================================================

  async getDevToDailyTip(): Promise<DevToArticle | null> {
    const cacheKey = 'devto_daily_tip';
    const cached = this.cache.get(cacheKey) as DevToArticle | null;
    if (cached) return cached;

    try {
      const response = await axios.get(`${BASE_URLS.devTo}/articles`, {
        params: {
          tag: 'tips,javascript,programming',
          top: 7,
          per_page: 10,
        },
        headers: this.getDevToHeaders(),
      });

      const articles: DevToArticle[] = response.data.map((article: any) => ({
        title: article.title,
        description: article.description,
        url: article.url,
        tags: article.tag_list,
        author: {
          name: article.user.name,
          username: article.user.username,
          profile_image: article.user.profile_image_90,
        },
        published_at: article.published_at,
        positive_reactions_count: article.positive_reactions_count,
        cover_image: article.cover_image,
      }));

      // Pick a random article from the top 10
      const dailyTip = articles[Math.floor(Math.random() * articles.length)];

      this.cache.set(cacheKey, dailyTip, 24 * 60 * 60 * 1000); // 24 hours
      return dailyTip;
    } catch (error) {
      const err = error as AxiosError;
      log.error('Error fetching Dev.to Daily Tip', {
        error: err.response?.data || err.message,
      });
      return null;
    }
  }

  async searchDevToArticles(query: string, tag?: string | null): Promise<DevToArticle[]> {
    try {
      const params: any = { per_page: 20 };
      if (tag) params.tag = tag;

      const response = await axios.get(`${BASE_URLS.devTo}/articles`, {
        params,
        headers: this.getDevToHeaders(),
      });

      return response.data
        .filter(
          (article: any) =>
            article.title.toLowerCase().includes(query.toLowerCase()) ||
            article.description?.toLowerCase().includes(query.toLowerCase()),
        )
        .slice(0, 5)
        .map((article: any) => ({
          title: article.title,
          description: article.description,
          url: article.url,
          tags: article.tag_list,
          author: article.user.name,
          published_at: article.published_at,
        }));
    } catch (error) {
      const err = error as AxiosError;
      log.error('Error searching Dev.to', {
        error: err.response?.data || err.message,
      });
      return [];
    }
  }

  // =====================================================================
  // STACK OVERFLOW
  // =====================================================================

  async getStackOverflowQuestionOfDay(): Promise<StackOverflowQuestion | null> {
    const cacheKey = 'stackoverflow_qod';
    const cached = this.cache.get(cacheKey) as StackOverflowQuestion | null;
    if (cached) return cached;

    try {
      const response = await axios.get(`${BASE_URLS.stackoverflow}/questions`, {
        params: {
          order: 'desc',
          sort: 'votes',
          tagged: 'javascript;node.js;react;vue.js;typescript',
          site: 'stackoverflow',
          pagesize: 10,
          filter: 'withbody',
        },
      });

      const questions: StackOverflowQuestion[] = response.data.items.map((q: any) => ({
        title: q.title,
        body: (q.body?.substring(0, 500) || '') + '...',
        url: q.link,
        score: q.score,
        answer_count: q.answer_count,
        view_count: q.view_count,
        tags: q.tags,
        owner: {
          name: q.owner.display_name,
          reputation: q.owner.reputation,
        },
        creation_date: new Date(q.creation_date * 1000),
      }));

      const questionOfDay =
        questions[Math.floor(Math.random() * Math.min(5, questions.length))];

      this.cache.set(cacheKey, questionOfDay, 24 * 60 * 60 * 1000); // 24 hours
      return questionOfDay;
    } catch (error) {
      const err = error as AxiosError;
      log.error('Error fetching StackOverflow QOD', {
        error: err.response?.data || err.message,
      });
      return null;
    }
  }

  // =====================================================================
  // YOUTUBE
  // =====================================================================

  async searchYouTubeDevVideos(
    query: string,
    language: string = 'fr',
  ): Promise<YouTubeVideo[]> {
    const cacheKey = `youtube_${query}_${language}`;
    const cached = this.cache.get(cacheKey) as YouTubeVideo[] | null;
    if (cached) return cached;

    try {
      if (!this.apiKeys.youtube) {
        log.warn('YouTube API key missing');
        return [];
      }

      const searchQuery = `${query} programmation developpement ${language === 'fr' ? 'francais' : ''}`;

      const response = await axios.get(`${BASE_URLS.youtube}/search`, {
        params: {
          part: 'snippet',
          q: searchQuery,
          type: 'video',
          order: 'relevance',
          maxResults: 10,
          videoDefinition: 'high',
          videoDuration: 'medium',
          key: this.apiKeys.youtube,
        },
      });

      const videos: YouTubeVideo[] = response.data.items.map((item: any) => ({
        title: item.snippet.title,
        description: item.snippet.description,
        url: `https://www.youtube.com/watch?v=${item.id.videoId}`,
        thumbnail: item.snippet.thumbnails.medium.url,
        channel: {
          name: item.snippet.channelTitle,
          id: item.snippet.channelId,
        },
        published_at: item.snippet.publishedAt,
      }));

      this.cache.set(cacheKey, videos, 60 * 60 * 1000); // 1 hour
      return videos;
    } catch (error) {
      const err = error as AxiosError;
      log.error('Error searching YouTube', {
        error: err.response?.data || err.message,
      });
      return [];
    }
  }

  // =====================================================================
  // COMPOSITE HELPERS
  // =====================================================================

  async getTechNewsOfTheDay(): Promise<{
    devTip: DevToArticle | null;
    stackOverflowQOD: StackOverflowQuestion | null;
    trendingRepo: GitHubRepo | null;
  }> {
    const [devToTip, soQuestion, trending] = await Promise.all([
      this.getDevToDailyTip(),
      this.getStackOverflowQuestionOfDay(),
      this.getGitHubTrending('javascript', 'daily'),
    ]);

    return {
      devTip: devToTip,
      stackOverflowQOD: soQuestion,
      trendingRepo: trending?.[0] || null,
    };
  }

  async getUserDevStats(githubUsername: string): Promise<GitHubUserActivity | null> {
    if (!githubUsername) return null;
    return this.getGitHubUserActivity(githubUsername);
  }

  // =====================================================================
  // PRIVATE HELPERS
  // =====================================================================

  private getGitHubHeaders(): Record<string, string> {
    const headers: Record<string, string> = {
      Accept: 'application/vnd.github.v3+json',
      'User-Agent': 'Discord-Bot-TaureauCeltique/3.0',
    };
    if (this.apiKeys.github) {
      headers['Authorization'] = `token ${this.apiKeys.github}`;
    }
    return headers;
  }

  private getDevToHeaders(): Record<string, string> {
    const headers: Record<string, string> = {
      Accept: 'application/vnd.forem.api-v1+json',
    };
    if (this.apiKeys.devTo) {
      headers['api-key'] = this.apiKeys.devTo;
    }
    return headers;
  }

  private calculateCommitStreak(events: any[]): number {
    const pushEvents = events.filter((e: any) => e.type === 'PushEvent');
    if (pushEvents.length === 0) return 0;

    let streak = 0;
    const currentDate = new Date();
    currentDate.setHours(0, 0, 0, 0);

    for (let i = 0; i < 30; i++) {
      const dayStart = new Date(currentDate);
      const dayEnd = new Date(currentDate);
      dayEnd.setHours(23, 59, 59, 999);

      const hasCommitThisDay = pushEvents.some((event: any) => {
        const eventDate = new Date(event.created_at);
        return eventDate >= dayStart && eventDate <= dayEnd;
      });

      if (hasCommitThisDay) {
        streak++;
      } else if (i > 0) {
        // Don't break on first day if no commits today
        break;
      }

      currentDate.setDate(currentDate.getDate() - 1);
    }

    return streak;
  }

  private extractEventPayload(event: any): any {
    switch (event.type) {
      case 'PushEvent':
        return {
          commits: event.payload.commits?.length || 0,
          branch: event.payload.ref?.replace('refs/heads/', ''),
        };
      case 'IssuesEvent':
        return {
          action: event.payload.action,
          issue_title: event.payload.issue?.title,
        };
      case 'PullRequestEvent':
        return {
          action: event.payload.action,
          pr_title: event.payload.pull_request?.title,
        };
      default:
        return {};
    }
  }

  // =====================================================================
  // CACHE MANAGEMENT (delegated to CacheManager)
  // =====================================================================

  clearCache(): void {
    this.cache.clear();
  }

  getCacheStats() {
    return this.cache.getStats();
  }
}

// Singleton instance
export const externalApiService = new ExternalApiService();
