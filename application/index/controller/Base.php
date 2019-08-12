<?php
namespace app\index\controller;

use think\Controller;

class Base extends Controller {
    public function initialize() {
        if (!session('?type')) {
            apiReturn(-1, 'no_right')->send();
            exit;
        }
    }
}
