import axios from "axios"
const url = 'https://nominatim.openstreetmap.org/'

export const NomReverseGeocode = (lat : number, lng : number) => {
    return axios.get(url + 'reverse', {
        headers: {
            "Accept-Language": "en-US,en;"
        },
        params: {
            lat: lat,
            lon: lng,
            format: 'geocodejson'
        }
    })
}