import { getCurrentUser } from 'vuefire';

export const authCheck = async (to : any, from: any) => {
    const user = await getCurrentUser()
    console.log(to.params)
    if(!user) {
        var movie_id = to.params.movie_id
        var loc_id = to.params.edit_loc_id
        return { name: 'movieLocation', params: {movie_id: movie_id, loc_id: loc_id}}
    }
}