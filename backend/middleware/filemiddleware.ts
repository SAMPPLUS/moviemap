import path from 'path';
import multer from 'multer'
export default class FileMiddleware {
    public static readonly memoryLoader = multer({
      storage: multer.memoryStorage(),
      limits: {
        fileSize: 2097152, // 2 MByte
      },
    });
  
    public static readonly diskLoader = multer({
      storage: multer.diskStorage({
        destination: (_req, _file, cb) => {
          cb(null, path.join(__dirname, '../public/images'));
        },
        filename: function (req, file, cb) {
          cb(null, Date.now()+ '-' + file.originalname)
        }
      }),
      limits: {
        fileSize: 67108864, // 64 MByte
      },
    });
  }