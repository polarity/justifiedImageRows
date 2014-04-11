(function() {
  window.calcImageDimensions = function(width, height, newWidth, newHeight) {
    var outHeight, outWidth, ratio;
    if (!width || !height) {
      throw new Error("calcImageDimensions() requires width & height for calculation");
    }
    if (!newWidth && !newHeight) {
      throw new Error("calcImageDimensions() requires either a value for newWidth or newHeight");
    }
    if (width > height) {
      ratio = width / height;
    } else {
      ratio = height / width;
    }
    if (newWidth) {
      if (width > height) {
        outHeight = Math.floor(newWidth / ratio);
      } else {
        outHeight = Math.floor(newWidth * ratio);
      }
      outWidth = newWidth;
    }
    if (newHeight) {
      outHeight = newHeight;
      if (width > height) {
        outWidth = Math.floor(newHeight * ratio);
      } else {
        outWidth = Math.floor(newHeight / ratio);
      }
    }
    return {
      width: outWidth,
      height: outHeight
    };
  };

}).call(this);
