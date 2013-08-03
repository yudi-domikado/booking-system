gon.watch = function(name, possibleOptions, possibleCallback) {
  var callback, key, options, performAjax, timer, value, _base, _ref, _ref1;
  if (typeof $ === 'undefined' || $ === null) {
    return;
  }
  if (typeof possibleOptions === 'object') {
    options = {};
    callback = possibleCallback;
    _ref = gon.watchedVariables[name];
    for (key in _ref) {
      value = _ref[key];
      options[key] = value;
    }
    for (key in possibleOptions) {
      value = possibleOptions[key];
      options[key] = value;
    }
  } else {
    options = gon.watchedVariables[name];
    callback = possibleOptions;
  }
  performAjax = function() {
    var ajax_opts = {
      type: options.type,
      url: options.url,
      dataType: options.dataType || 'html',
      data: {
        gon_return_variable: true,
        gon_watched_variable: name
      }
    };
    var xhr = $.ajax(ajax_opts);
    return xhr.complete(callback);
  };
  if (options.interval) {
    timer = setInterval(performAjax, options.interval);
    if ((_ref1 = (_base = gon._timers)[name]) == null) {
      _base[name] = [];
    }
    return gon._timers[name].push({
      timer: timer,
      fn: callback
    });
  } else {
    return performAjax();
  }
};