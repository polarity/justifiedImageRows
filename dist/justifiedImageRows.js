(function() {
  var createRows, recalcRow;

  createRows = function(images, height, maxWidth) {
    var allRows, currentRow;
    allRows = [];
    currentRow = {
      width: 0,
      images: []
    };
    images.forEach(function(image, index) {
      var oHeight, oWidth;
      oWidth = image.element.offsetWidth;
      oHeight = image.element.offsetHeight;
      image.resizeTo = calcImageDimensions(oWidth, oHeight, null, height);
      currentRow.width += image.resizeTo.width;
      currentRow.images.push(image);
      if (currentRow.width >= maxWidth || index + 1 === images.length) {
        allRows.push(currentRow);
        return currentRow = {
          width: 0,
          images: []
        };
      }
    });
    return allRows;
  };

  recalcRow = function(images, height) {
    var currentRow;
    currentRow = {
      width: 0,
      images: []
    };
    images.forEach(function(image, index) {
      var oHeight, oWidth;
      oWidth = image.element.offsetWidth;
      oHeight = image.element.offsetHeight;
      image.resizeTo = calcImageDimensions(oWidth, oHeight, null, height);
      currentRow.width += image.resizeTo.width;
      return currentRow.images.push(image);
    });
    return currentRow;
  };

  window.justifiedImageRows = function(bestHeight, images, maxWidth) {
    var imageArr, recalculatedRows, rows;
    if (!bestHeight) {
      throw new Error("bestHeight is not set");
    }
    if (!images) {
      throw new Error("no images array are given");
    }
    if (!maxWidth) {
      throw new Error("maxWidth must be set");
    }
    if (!Array.isArray(images)) {
      throw new Error("images parameter must be an array");
    }
    imageArr = [];
    images.forEach(function(image, index) {
      return imageArr.push({
        element: image
      });
    });
    rows = createRows(imageArr, bestHeight, maxWidth);
    recalculatedRows = [];
    rows.forEach(function(row, index) {
      var i;
      i = 0;
      while (row.width > maxWidth) {
        row = recalcRow(row.images, bestHeight--);
        i++;
        if (i > 3000) {
          break;
        }
      }
      while (row.width < maxWidth && row.width < (maxWidth - 2)) {
        row = recalcRow(row.images, bestHeight++);
        i++;
        if (i > 3000) {
          break;
        }
      }
      return recalculatedRows.push(row);
    });
    recalculatedRows.forEach(function(row, index) {
      return row.images.forEach(function(image, index2) {
        return image.element.width = image.resizeTo.width;
      });
    });
  };

}).call(this);
