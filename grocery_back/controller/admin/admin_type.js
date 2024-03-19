const db = require('../../helper/db_helper')
const helper = require('../../helper/helper')
const multiparty = require('multiparty')
const fs = require('fs')
const {checkAccessToken, getProductDetail} = require('../../common/function_common')
const message = require('../../common/message')
const imageSavePath = "./public/img/";
const image_base_url = helper.ImagePath();       

module.exports.controller = (app, io, user_socket_connect_list) => {

    app.post("/api/grocerygo/admin/type/add", (request, response) => {
        var form = new multiparty.Form();

        checkAccessToken(request.headers, response, "2", () => {

            form.parse(request, (error, reqObject, files) => {
                if (error) {
                    helper.ThrowHtmlError(error, response);
                    return
                }

                helper.Dlog("----- Parameter -----")
                helper.Dlog(reqObject)
                helper.Dlog("----- Files -----")
                helper.Dlog(files)

                helper.CheckParameterValid(response, reqObject, ["t_name", "t_color"], () => {
                    helper.CheckParameterValid(response, files, ["t_image"], () => {
                        var extension = files.t_image[0].originalFilename.substring(files.t_image[0].originalFilename.lastIndexOf(".") + 1);

                        var imageFileName = "type/" + helper.fileNameGenerate(extension);
                        var newPath = imageSavePath + imageFileName;

                        fs.rename(files.t_image[0].path, newPath, (error) => {
                            if (error) {
                                helper.ThrowHtmlError(error, response);
                                return
                            } else {
                                db.query("INSERT INTO `type`( `t_name`, `t_image`, `t_color`, `t_created_date`, `t_modify_date`) VALUES  (?, ?, ?, NOW(), NOW())", [
                                    reqObject.t_name[0], imageFileName, reqObject.t_color[0]
                                ], (error, result) => {

                                    if (error) {
                                        helper.ThrowHtmlError(error, response);
                                        return;
                                    }

                                    if (result) {
                                        response.json({
                                            "status": "1", "payload": {
                                                "type_id": result.insertId,
                                                "t_name": reqObject.t_name[0],
                                                "t_color": reqObject.t_color[0],
                                                "t_image": image_base_url + imageFileName,
                                            }, "message": message.msg_type_added
                                        });
                                    } else {
                                        response.json({ "status": "0", "message": message.msg_fail })
                                    }

                                })
                            }
                        })
                    })
                })

            })

        })
    })

    app.post("/api/grocerygo/admin/type/update", (request, response) => {
        var form = new multiparty.Form();

        checkAccessToken(request.headers, response, "2", () => {

            form.parse(request, (error, reqObject, files) => {
                if (error) {
                    helper.ThrowHtmlError(error, response);
                    return
                }

                helper.Dlog("----- Parameter -----")
                helper.Dlog(reqObject)
                helper.Dlog("----- Files -----")
                helper.Dlog(files)

                helper.CheckParameterValid(response, reqObject, ["type_id", "t_name", "t_color"], () => {

                    var condition = "";
                    var imageFileName = "";

                    if (files.t_image != undefined || files.t_image != null) {
                        var extension = files.t_image[0].originalFilename.substring(files.t_image[0].originalFilename.lastIndexOf(".") + 1);

                        imageFileName = "type/" + helper.fileNameGenerate(extension);
                        var newPath = imageSavePath + imageFileName;

                        condition = " `t_image` = '" + imageFileName + "', ";
                        fs.rename(files.t_image[0].path, newPath, (error) => {
                            if (error) {
                                helper.ThrowHtmlError(error);
                                return
                            }
                        })
                    }

                    db.query("UPDATE `type` SET `t_name` = ?," + condition + " `t_color` = ?, `t_modify_date` = NOW() WHERE `type_id`= ? AND `t_status` = ? ", [
                        reqObject.t_name[0], reqObject.t_color[0], reqObject.type_id[0], "1"
                    ], (error, result) => {

                        if (error) {
                            helper.ThrowHtmlError(error, response);
                            return;
                        }

                        if (result) {
                            response.json({
                                "status": "1", "payload": {
                                    "type_id": parseInt(reqObject.type_id[0]),
                                    "t_name": reqObject.t_name[0],
                                    "t_color": reqObject.t_color[0],
                                    "t_image": image_base_url + imageFileName,
                                }, "message": message.msg_type_update
                            });
                        } else {
                            response.json({ "status": "0", "message": message.msg_fail })
                        }

                    })
                })

            })

        })
    })

    app.post('/api/grocerygo/admin/type/delete', (request, response) => {
        helper.Dlog(request.body);
        var reqObject = request.body;

        helper.CheckParameterValid(response, reqObject, ["type_id"], () => {

            checkAccessToken(request.headers, response, "2", () => {
                db.query("UPDATE `type` SET `t_status`= ?, `t_modify_date` = NOW() WHERE `type_id`= ? ", [
                    "2", reqObject.type_id,
                ], (error, result) => {

                    if (error) {
                        helper.ThrowHtmlError(error, response);
                        return;
                    }

                    if (result.affectedRows > 0) {
                        response.json({
                            "status": "1", "message": message.msg_type_delete
                        });
                    } else {
                        response.json({ "status": "0", "message": message.msg_fail })
                    }

                })
            })
        })
    })

    app.post('/api/grocerygo/admin/type/list', (request, response) => {
        helper.Dlog(request.body);

        checkAccessToken(request.headers, response, "2", () => {
            db.query("SELECT `type_id`, `t_name`,  (CASE WHEN `t_image` != '' THEN CONCAT('" + image_base_url + "','',`t_image`)  ELSE `t_image` END) AS `t_image` , `t_color` FROM `type` WHERE `t_status`= ? ", [
                "1"
            ], (error, result) => {

                if (error) {
                    helper.ThrowHtmlError(error, response);
                    return;
                }

                response.json({
                    "status": "1", "payload": result
                });
            })
        })
    })
}