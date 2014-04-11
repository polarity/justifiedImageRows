# justifiedImageRows()

Resize image elements inside a container until they fit, divided into rows, inside the container. It´s basically the [current flickr photo grid](https://www.flickr.com/photos/polarity). Images in all rows are always matching exactly the container width. It´s very simple and there are currently not many options avaiable.

## Installing

Download the module via bower

    bower install justifiedImageRows

Append it to you´re page via script tag or use the great [grunt bower_concat](https://github.com/sapegin/grunt-bower-concat) task to automate this task for all bower components:

    <script src="bower_components/dist/justifiedImageRows.js"></script>

## Usage

basically you just have to call the method one time

    justifiedImageRows(bestHeight, images, maxWidth)

The method takes some basic parameters so it dont depends on any big library.

    bestHeight = 100; // you´re row height you want to start with
    images = []; // an Array() of dom img elements
    maxWidth = 1000; // the width in px where the row should fit in

The method starts with the "bestHeight" row height and determines how many images fit into one row when all images would be resized to an height of "bestHeight". Then it starts to decrease the row height one by one pixel until the width is exactly the maxWidth or below. Then it continues with the next row until all images are fitted. In the end all images are resized to the calculated width and height.

## Examples

start with some simple html

    <div class="Gallerybox">
        <img src="hallo.jpg">
        <img src="hallo1.jpg">
        <img src="hallo2.jpg">
        <img src="hallo3.jpg">
        <img src="hallo4.jpg">
    </div>

you can use jquery to collect all parameters:

    // wait until all images are loaded on the site
    // or we dont get the correct dimensions
    $(window).load(function(){

        // collect 
        bestHeight = 800;
        images = $('.Gallerybox img').toArray();
        maxWidth = $('.Gallerybox').width();

        // resize
        justifiedImageRows(bestHeight, images, maxWidth);
    });

make it responsive

    function responsiveImageGrid(){
        // collect 
        bestHeight = 800;
        images = $('.Gallerybox img').toArray();
        maxWidth = $('.Gallerybox').width();

        // resize
        justifiedImageRows(bestHeight, images, maxWidth);
    }

    // execute after all images loaded
    $(window).load(responsiveImageGrid)

    // execute on every browser resize
    $(window).resize(responsiveImageGrid)
