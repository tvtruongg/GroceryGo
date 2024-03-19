const { error } = require('console');
var db = require('../../helper/db_helper')
var helper = require('../../helper/helper')
var multiparty = require('multiparty')
var fs = require('fs')
var imageSavePath = "./public/img/";


module.exports.controller = (app, io, user_socket_connect_list) => {
    const msg_success = "successfully";
    const msg_fail = "fail";
    const msg_invalidUser = "invalid username and password";

    app.post('/api/grocery/upload/image', (request, response) => {
        var form = new multiparty.Form();
        form.parse(request, (error, responseObject, files) => {
            if (error) {
                helper.ThrowHtmlError(error, response);
                return;
            }

            helper.Dlog('------ Parameter -----');
            helper.Dlog(responseObject);

            helper.Dlog('------ Files -----');
            helper.Dlog(files);

            if(files.image != undefined || files.image != null) {
                var extension = files.image[0].originalFilename.substring(files.image[0].originalFilename.lastIndexOf(".") + 1);

                // Tên ảnh
                var imageFileName = "product/" + helper.fileNameGenerate(extension);
                // 
                var newPath = imageSavePath + imageFileName;
                fs.rename(files.image[0].path, newPath, (error) => {
                    if (error) {
                        helper.ThrowHtmlError(error);
                        return;
                    } else {
                        var name = responseObject.name[0];
                        var address = responseObject.address[0];

                        helper.Dlog(name);
                        helper.Dlog(address);

                        response.json({
                            "status": "1",
                            "payload": {"name": name, "address": address, "image": helper.ImagePath() + imageFileName},
                            "message": msg_success
                        })
                    }
                })
            }
        })
    })

    // Lưu nhiều hình ảnh
    app.post('/api/grocery/upload/multiple/image', (request, response) => {
        var form = new multiparty.Form();
        form.parse(request, (error, responseObject, files) => {
            if (error) {
                helper.ThrowHtmlError(error, response);
                return;
            }

            helper.Dlog('------ Parameter -----');
            helper.Dlog(responseObject);

            helper.Dlog('------ Files -----');
            helper.Dlog(files);

            if(files.image != undefined || files.image != null) {
                var imageNamePathArray = [];
                var fullImageNamePathArray = [];
                files.image.forEach(imageFile => {
                    var extension = imageFile.originalFilename.substring(imageFile.originalFilename.lastIndexOf(".") + 1);

                    // Tên ảnh
                    var imageFileName = "user/" + helper.fileNameGenerate(extension);

                    imageNamePathArray.push(imageFileName);
                    fullImageNamePathArray.push(helper.ImagePath() + imageFileName);
                    saveImage(imageFile, imageSavePath + imageFileName);
                });

                helper.Dlog(imageNamePathArray);
                helper.Dlog(fullImageNamePathArray);

                var name = responseObject.name;
                var address = responseObject.address;

                helper.Dlog(name);
                helper.Dlog(address);

                // In lên postman
                response.json({
                    "status": "1",
                    "payload": {"name": name, "address": address, "image": fullImageNamePathArray},
                    "message": msg_success
                })
            }
        })
    })

    function saveImage(imageFile, savePath) {
        fs.rename(imageFile.path, savePath, (error) => {
            if (error) {
                helper.ThrowHtmlError(error);
                return;
            }
        })
    }
};
























