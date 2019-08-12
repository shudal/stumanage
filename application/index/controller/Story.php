<?php
namespace app\index\controller;

class Story extends Base {
    public function add() {
        if (!request()->isPost()) {
            return 'hi';
        }

        $data = input('post.');
        $data['create_time'] = strtotime('now')."000";
        model('Story')->save($data);
        return apiReturn(1, 'OK');
    }

    public function get() {
        if (!request()->isGet()) {
            return 'hi';
        }

        $stories = model('Story')->where('stuid', input('get.stuid'))->select();
        if ($stories == null) {
            return apiReturn(-1, 'null');
        }


        $stories = $stories->toArray();
        for ($i=0; $i<count($stories); $i = $i + 1) {
            $stories[$i]['create_time'] = date( "Y-m-d", substr($stories[$i]['create_time'], 0, 10));
        }
        return apiReturn(1, 'OK', $stories);
    }

}
