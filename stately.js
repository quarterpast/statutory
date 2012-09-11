(function(){
  var EventEmitter;
  EventEmitter = require('events').EventEmitter;
  exports.Context = function(initialState){
    var state, ref$;
    return (function(){
      var this$ = this;
      this.setState(initialState);
      function dispatch(methods){
        var func, args, that, results$ = [];
        for (func in methods) {
          args = methods[func];
          if ((that = bind$(state, func)) != null) {
            results$.push(that.apply(null, args));
          } else {
            throw TypeError("State " + state.displayName + " has no method '" + func + "'");
          }
        }
        return results$;
      }
      return importAll$(dispatch, this);
    }.call((ref$ = clone$(new EventEmitter), ref$.setState = function(){
      var ref$;
      return this.emit('state-change', state = (ref$ = new arguments[0], ref$.context = this, ref$));
    }, ref$)));
  };
  function bind$(obj, key, target){
    return function(){ return (target || obj)[key].apply(obj, arguments) };
  }
  function importAll$(obj, src){
    for (var key in src) obj[key] = src[key];
    return obj;
  }
  function clone$(it){
    function fun(){} fun.prototype = it;
    return new fun;
  }
}).call(this);
