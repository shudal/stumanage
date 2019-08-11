<?php
namespace app\index\controller;

class Student extends Base {
    public function add() {
        if (!request()->isPost()) {
            return 'hi';
        }

        $student = model('Student')->where('stuid', input('post.stuid'))->find();
        if ($student != null) {
            return apiReturn(-1, 'stuid_exists');
        }

        $file = request()->file('file');
        $info = $file->move('../uploads');
        if ($info) {
            /*
            dump($info->getExtension());
            dump($info->getSaveName());
            dump($info->getFilename());
            */
        } else {
            return apiReturn(-1, $file->getError());
        }

        $data = input('post.');
        $data['pic'] = $info->getSaveName();
        model('Student')->save($data);

        return apiReturn(1, 'OK');
    }

    public function hello() {
        return 'ka';
    }

}
