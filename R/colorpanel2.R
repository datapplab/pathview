colorpanel2<-
  function (n, low, mid, high)
  {
    if (missing(mid) || missing(high)) {
      low <- col2rgb(low)
      if (missing(high))
        high <- col2rgb(mid)
      else high <- col2rgb(high)
      red <- seq(low[1, 1], high[1, 1], length = n)/255
      green <- seq(low[3, 1], high[3, 1], length = n)/255
      blue <- seq(low[2, 1], high[2, 1], length = n)/255
    }
    else {
      isodd <- n%%2 == 1
      if (isodd) {
        n <- n + 1
      }
      low <- col2rgb(low)
      mid <- col2rgb(mid)
      high <- col2rgb(high)
      lower <- floor(n/2)
      upper <- n - lower
      red <- c(seq(low[1, 1], mid[1, 1], length = lower),
               seq(mid[1, 1], high[1, 1], length = upper))/255
      green <- c(seq(low[3, 1], mid[3, 1], length = lower),
                 seq(mid[3, 1], high[3, 1], length = upper))/255
      blue <- c(seq(low[2, 1], mid[2, 1], length = lower),
                seq(mid[2, 1], high[2, 1], length = upper))/255
      if (isodd) {
        red <- red[-(lower + 1)]
        green <- green[-(lower + 1)]
        blue <- blue[-(lower + 1)]
      }
    }
    rgb(red, blue, green)
  }
