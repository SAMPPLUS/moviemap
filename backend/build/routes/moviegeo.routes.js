"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
var router = express_1.default.Router();
var controller = require('../controllers/moviegeo.ctrl');
const validate = require('./validate');
var schema = require('./schema/moviegeo.schema');
router.post('/minsert', validate(schema.mInsertSchema), controller.movieInsert);
router.get('/mget', controller.movieGet);
module.exports = router;
