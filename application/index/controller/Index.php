<?php
namespace app\index\controller;

use think\Controller;

class Index extends Controller
{
    public function index()
    {
        if (!session('?type')) {
            return redirect('index/index/login');
        }
    }

    public function login() {
        if (!request()->isPost()) {
            return 'hi';
        }

        $user = model('Super')->where('username', input('post.username'))->find();
        if ($user == null) {
            return apiReturn(-1, 'user_not_exist');
        }

        if ($user->password != md5(input('post.password'))) {
            return apiReturn(-1, 'password_wrong');
        }

        $data = [];
        $data['type'] = $user->type;
        session('type', $user->type);
        return apiReturn(1, 'OK', $data);
    }
}
