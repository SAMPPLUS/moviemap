/**
 * This file was automatically generated by joi-to-typescript
 * Do not modify this file manually
 */

export interface locationReq {
  /**
   * Unknown Property
   */
  [x: string]: unknown;
  images: ({
    description: string;
    id: number;
    main?: boolean;
    type: 1 | 2;
  })[];
  location: {
    g_streetview_embed_url?: string | null | '';
    location_desc: string;
    location_name: string;
    movie_id: number;
    position: {
      lat: number;
      lng: number;
    };
    scene_desc: string;
    title: string;
  };
}

export interface updlocationReq {
  /**
   * Unknown Property
   */
  [x: string]: unknown;
  images: ({
    description?: string;
    id: number;
    main?: boolean;
    status: 'update' | 'new';
    type?: 1 | 2;
  })[];
  location: {
    g_streetview_embed_url?: string | null | '';
    id: number;
    location_desc?: string;
    location_name?: string;
    position?: {
      lat: number;
      lng: number;
    };
    scene_desc?: string;
    title?: string;
  };
}
