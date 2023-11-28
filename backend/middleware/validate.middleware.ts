import joi from 'joi'
import { Request, Response, NextFunction } from 'express';
import { ValueRequest } from '../interfaces/request.intrf';

export const validate = (schema : joi.Schema) => {
  return (req: Request, res: Response, next: NextFunction) => {
    const result = schema.validate({query: req.query, body: req.body, params: req.params});
    if (result.error) {
      console.log(result)
      return res.status(400).json({
        error: result.error.details[0].message,
      });
    }
    if (!('value' in req)) {
      req.value = {};
    }
    console.log(result.value)
    req.value = result.value;
    next();
  };
};