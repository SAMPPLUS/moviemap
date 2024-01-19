import admin from 'firebase-admin';
import { DecodedIdToken } from 'firebase-admin/lib/auth/token-verifier';

const checkAuth = (req: any, res : any, next: any) => {
    if (req.headers.authorization) {
      admin.auth().verifyIdToken(req.headers.authorization)
        .then((decodedToken: DecodedIdToken) => {
          console.log(decodedToken.uid, decodedToken.email)
          next()
        }).catch((error : Error) => {
          console.log(error)
          res.status(403).json({message: 'Auth verification failed'})
        });
    } else {
      
      res.status(403).json({message: "Missing authorization token"})
    }
  }

export default checkAuth