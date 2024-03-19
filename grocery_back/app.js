const createError = require('http-errors');
const express = require('express');
const path = require('path');
const cookieParser = require('cookie-parser');
const logger = require('morgan');

const cors = require('cors');
const fs = require('fs');

const indexRouter = require('./routes/index');
const usersRouter = require('./routes/users');
const helper = require('./helper/helper');

const app = express();
const server = require('http').createServer(app);

// Nhận kết nối của client
var io = require('socket.io')(server, {
  cors: {
  origin: '*',
  methods: ["GET", "POST"]
}
});
const serverPort = 2002;

var user_socket_connect_list = [];

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json({ limit: '100mb' }));
app.use(express.urlencoded({ extended: true, limit: '100mb' }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/users', usersRouter);

const corsOptions = {
  origin: '*',
}

app.use(cors(corsOptions));

// Đọc tệp tin tự động
try {
  const controllerDir = "./controller";
  // Lấy các tập tin trong trong controller
    fs.readdirSync(controllerDir).forEach((folder) => {
    fs.readdirSync(`${controllerDir}/${folder}`).forEach((file) => {
      if (file.endsWith(".js")) {
        // Lấy đường dẫn của tập tin
        const filePath = `${controllerDir}/${folder}/${file}`;
        // Yêu cầu tải tập tin
        const route = require(`${filePath}`);
        // Thực thi các route
        route.controller(app, io, user_socket_connect_list);
      }
    });
  });
    // Thông báo
    helper.Dlog("Triển khai thành công controller... (" + helper.serverYYYYMMDDHHmmss() + ")");
  } catch (error) {
    console.error('Lỗi khi triển khai controllers:', error);
}

// catch 404 and forward to error handler
app.use(function (req, res, next) {
  next(createError(404));
});

// error handler
app.use(function (err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;

server.listen(serverPort);

console.log("Server Start : " + serverPort );

Array.prototype.swap = (x, y) => {
  var b = this[x];
  this[x] = this[y];
  this[y] = b;
  return this;
}

Array.prototype.insert = (index, item) => {
  this.splice(index, 0, item);
}

Array.prototype.replace_null = (replace = '""') => {
  return JSON.parse(JSON.stringify(this).replace(/null/g, replace));
}

String.prototype.replaceAll = (search, replacement) => {
  var target = this;
  return target.replace(new RegExp(search, 'g'), replacement);
}
