import axios from "axios";

const img_url = "https://image.tmdb.org/t/p/original"

const client = axios.create({
    headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "text/plain",
      },
})

const fetchImage = async (path : string) => {

}