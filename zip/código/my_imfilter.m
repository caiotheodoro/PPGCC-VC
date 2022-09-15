function output = my_imfilter(image, filter)
  output = imfilter(image, filter, 'conv', 'replicate');





