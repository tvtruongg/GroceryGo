const db = require('../../helper/db_helper')
const helper = require('../../helper/helper')
const multiparty = require('multiparty')
const fs = require('fs')
const {checkAccessToken, getProductDetail} = require('../../common/function_common')
const message = require('../../common/message')
const imageSavePath = "./public/img/";
const image_base_url = helper.ImagePath();       

module.exports.controller = (app, io, user_socket_connect_list) => {

    // API Add
    app.post("/api/grocerygo/admin/category/add", (request, response) => {
        // Khi yêu cầu HTTP có chứa dữ liệu đa phần, như tệp tin tải lên hoặc dữ liệu biểu mẫu đa phần, ta sử dụng multiparty
        const form = new multiparty.Form();

        checkAccessToken(request.headers, response, "2", () => {
            // phân tích yêu cầu và nhận dữ liệu đa phần (reqObject: Dữ liệu từ các trường trong biểu mẫu, files: Tệp tin tải lên).
            form.parse(request, (error, reqObject, files) => {
                if (error) {
                    helper.ThrowHtmlError(error, response);
                    return
                }

                // Thông báo
                helper.Dlog("----- Parameter -----")
                helper.Dlog(reqObject)
                helper.Dlog("----- Files -----")
                helper.Dlog(files)

                // Kiểm tra Post
                helper.CheckParameterValid(response, reqObject, ["category_name", "ca_color"], () => {
                    // Kiểm tra file
                    helper.CheckParameterValid(response, files, ["ca_image"], () => {
                        var extension = files.ca_image[0].originalFilename.substring(files.ca_image[0].originalFilename.lastIndexOf(".") + 1);

                        var imageFileName = "category/" + helper.fileNameGenerate(extension);
                        var newPath = imageSavePath + imageFileName;
                        console.log(newPath);
                        fs.rename(files.ca_image[0].path, newPath, (error) => {
                            if (error) {
                                helper.ThrowHtmlError(error, response);
                                return
                            } else {
                                db.query("INSERT INTO `category`( `category_name`, `ca_image`, `ca_color`, `ca_created_date`, `ca_modify_date`) VALUES  (?, ?, ?, NOW(), NOW())", [
                                    reqObject.category_name[0], imageFileName, reqObject.ca_color[0]
                                ], (error, result) => {

                                    if (error) {
                                        helper.ThrowHtmlError(error, response);
                                        return;
                                    }

                                    if (result) {
                                        response.json({
                                            "status": "1", "payload": {
                                                "category_id": result.insertId,
                                                "category_name": reqObject.category_name[0],
                                                "ca_color": reqObject.ca_color[0],
                                                "ca_image": image_base_url + imageFileName,
                                            }, "message": message.msg_category_added
                                        });
                                    } else {
                                        res.json({ "status": "0", "message": message.msg_fail })
                                    }

                                })
                            }
                        })
                    })
                })

            })

        })
    })

    app.post("/api/grocerygo/admin/category/update", (request, response) => {
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

                helper.CheckParameterValid(response, reqObject, ["category_id", "category_name", "ca_color"], () => {

                    var condition = "";
                    var imageFileName = "";

                    // Kiểm tra xem có file có chưa ảnh không
                    if (files.ca_image != undefined || files.ca_image != null) {
                        // Lấy phần mở rộng của ảnh  (.jpq, .png)
                        var extension = files.ca_image[0].originalFilename.substring(files.ca_image[0].originalFilename.lastIndexOf(".") + 1);

                        imageFileName = "category/" + helper.fileNameGenerate(extension);
                        var newPath = imageSavePath + imageFileName;

                        // Câu lệnh cập nhập ảnh
                        condition = " `ca_image` = '" + imageFileName + "', ";
                        // di chuyển ảnh từ đường dẫn tạm thời sang vị trí lưu trữ mới.
                        fs.rename(files.ca_image[0].path, newPath, (error) => {
                            if (error) {
                                helper.ThrowHtmlError(error);
                                return
                            }
                        })
                    }


                    db.query("UPDATE `category` SET `category_name` = ?," + condition + " `ca_color` = ?, `ca_modify_date` = NOW() WHERE `category_id`= ? AND `ca_status` = ?", [
                        reqObject.category_name[0], reqObject.ca_color[0], reqObject.category_id[0], "1"
                    ], (error, result) => {

                        if (error) {
                            helper.ThrowHtmlError(error, response);
                            return;
                        }

                        if (result) {
                            response.json({
                                "status": "1", "payload": {
                                    "category_id": parseInt(reqObject.category_id[0]),
                                    "category_name": reqObject.category_name[0],
                                    "ca_color": reqObject.ca_color[0],
                                    "ca_image": image_base_url + imageFileName,
                                }, "message": message.msg_category_update
                            });
                        } else {
                            response.json({ "status": "0", "message": message.msg_fail })
                        }

                    })
                })

            })

        })
    })

    app.post('/api/grocerygo/admin/category/delete', (request, response) => {
        helper.Dlog(request.body);
        var reqObject = request.body;

        helper.CheckParameterValid(response, reqObject, ["category_id"], () => {

            checkAccessToken(request.headers, response, "2", () => {
                db.query("UPDATE `category` SET `ca_status`= ?, `ca_modify_date` = NOW() WHERE `category_id`= ? ", [
                    "2", reqObject.category_id,
                ], (error, result) => {

                    if (error) {
                        helper.ThrowHtmlError(error, response);
                        return;
                    }

                    if (result.affectedRows > 0) {
                        response.json({
                            "status": "1", "message": message.msg_category_delete
                        });
                    } else {
                        response.json({ "status": "0", "message": message.msg_fail })
                    }

                })
            })
        })
    })

    app.post('/api/grocerygo/admin/category/list', (request, response) => {
        helper.Dlog(request.body);

        checkAccessToken(request.headers, response, "2", () => {
            /*
                WHEN ca_image != '': kiểm tra ca_image có khác rỗng hay không.
                Sử dụng CONCAT để nối các chuỗi này lại với nhau.
                ELSE ca_image: Nếu điều kiện ở bước 1 là sai (tức là không có hình ảnh), biểu thức này sẽ giữ nguyên giá trị gốc của ca_image.
                Dấu phẩy trống, giúp biểu thức CASE trả về đường dẫn hình hoàn chỉnh
            */
            db.query("SELECT `category_id`, `category_name`,  (CASE WHEN `ca_image` != '' THEN CONCAT('" + image_base_url + "','',`ca_image`)  ELSE `ca_image` END) AS `ca_image` , `ca_color` FROM `category` WHERE `ca_status`= ? ", [
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