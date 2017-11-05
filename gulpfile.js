const gulp = require('gulp');
const sass = require('gulp-sass');

gulp.task('build', ['build-css']);

gulp.task('watch', function(){ 
    var watcher = gulp.watch(['./css-src/**/*'], ['build']);
    watcher.on('change', function (event) {
        console.log('Event type: ' + event.type); // added, changed, or deleted
        console.log('Event path: ' + event.path);
    });
});

gulp.task('build-css', function() {
    gulp.src('./css-src/main.scss')
    .pipe(sass({outputStyle: 'compressed'}).on('error', sass.logError))
    .pipe(gulp.dest('./assets/css/lib'))
})