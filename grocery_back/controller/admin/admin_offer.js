const db = require('../../helper/db_helper')
const helper = require('../../helper/helper')
const multiparty = require('multiparty')
const fs = require('fs')
const {checkAccessToken, getProductDetail} = require('../../common/function_common')
const message = require('../../common/message')
const imageSavePath = "../../public/img'";
const image_base_url = helper.ImagePath();       

module.exports.controller = (app, io, user_socket_connect_list) => {}