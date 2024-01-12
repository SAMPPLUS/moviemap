

export interface locationimages {
    id: string;
    location_id: string;
    path: string;
    file_name: string;
    type: number
    description: string
}

//table: locations
export interface location {
    id: string;
    movie_id: string;
    scene_desc: string;
    lat: number;
    lng: number;
    title?: string
    main_img_path?: string
}