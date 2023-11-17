import scheduledDb from "../db/scheduled.db"
import { Row } from "postgres"
import fs from 'fs'

const img_path : string= "./public/images/uploads/";

const cleanImages = async () => {
    console.log("CLEANING IMAGE FILES")
    //delete from db
    var deleted : Row[] = await scheduledDb.deleteUnlinkedImages();
    console.log(deleted);

    //delete from file system
    deleted.forEach((el : object) => {
        if('file_name' in el){
            fs.unlink(img_path + el.file_name, (err) => {
                if (err) console.log("failed to delete local image:"+err);
                else {
                    console.log("deleted file: " + el.file_name)
                }
            });
        }
    })

    //TODO: look for any files not linked to a locationimage row and delete from file system
}

export default {
    cleanImages
}