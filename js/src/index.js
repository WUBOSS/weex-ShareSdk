

const WeexShareSdk = {
  show() {
      alert("module WeexShareSdk is created sucessfully ")
  }
};


var meta = {
   WeexShareSdk: [{
    name: 'show',
    args: []
  }]
};



if(window.Vue) {
  weex.registerModule('WeexShareSdk', WeexShareSdk);
}

function init(weex) {
  weex.registerApiModule('WeexShareSdk', WeexShareSdk, meta);
}
module.exports = {
  init:init
};
