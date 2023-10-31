"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
require('dotenv').config();
// Initialize the express engine
var logger = require('morgan');
var movieGeoRouter = require('./routes/moviegeo.routes');
const app = (0, express_1.default)();
app.use(logger('dev'));
app.use(express_1.default.json());
app.use('/moviegeo', movieGeoRouter);
const port = process.env.PORT;
// Handling '/' Request
app.get('/', (req, res) => {
    res.send("TypeScript With Express");
});
// Server setup
app.listen(port, () => {
    console.log(`TypeScript with Express 
         http://localhost:${port}/`);
});
