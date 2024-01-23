
export type Location = {lat: number, lng: number, id: string, title: string, movie_id: string, main_img_path: string, scene_desc: string, location_name: string, location_desc: string, scene_img: string, scene_img_desc: string, loc_img: string, loc_img_desc: string, g_streetview_embed_url: string}
export interface locFormData  {id?: number, position : L.LatLng; title: string; scene_desc: string; location_name: string; location_desc: string; movie_id?: string; g_streetview_embed_url?: string}
