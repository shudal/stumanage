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

	$data = input('post.');
        $file = request()->file('file');
        if ($file == null) {
            // return apiReturn(-1, 'no_pic');
        } else {
        	$info = $file->move('../public/static/uploads');
        	if ($info) {
			$data['pic'] = $info->getSaveName();
            /*
            dump($info->getExtension());
            dump($info->getSaveName());
            dump($info->getFilename());
            */
        	} else {
            	return apiReturn(-1, $file->getError());
        	}
	}

        if ($data['birthday'] == "") {
		    unset($data['birthday']);
	    }
	model('Student')->save($data);

        return apiReturn(1, 'OK');
    }

    public function find() {
        if (!request()->isGet()) {
            return 'hi';
        }

        $data = input('get.');

        $whereData = [];
        if (input('?get.name') && !empty($data['name'])) {
            $whereData[] = ['name', 'like', '%'.input('get.name').'%'];
        }

        if (input('?get.stuid') && !empty($data['stuid'])) {
            $whereData[] = ['stuid', 'eq', input('get.stuid')];
        }


        $students = model('Student')->where($whereData)->select();

        if (!empty($data['page']) && !empty($data['limit'])) {
            $students = model('Student')->where($whereData)->paginate($data['limit'], false, [
                'list_rows' => $data['limit'],
                'page' => $data['page'],
            ]);
        }

        for ($i=0; $i<count($students->items()); $i = $i + 1) {
            // dump($students->items()[$i]);
            $students->items()[$i]['birthday'] = date( "Y-m-d", substr($students->items()[$i]['birthday'], 0, 10));
        }

        return apiReturn(1, 'OK', $students);
    }

    public function get() {
        if (!request()->isGet()) {
            return 'hi';
        }

        $student = model('Student')->get(input('get.id'));
        return apiReturn(1, 'OK', $student);
    }

    public function update() {
        if (!request()->isPost()) {
            return 'hi';
        }


        $data = input('post.');
        unset($data['id']);

        $file = request()->file('file');
        if ($file != null) {
            $info = $file->move('../public/static/uploads');
            if ($info) {
                /*
                dump($info->getExtension());
                dump($info->getSaveName());
                dump($info->getFilename());
                */
            } else {
                return apiReturn(-1, $file->getError());
            }
            $data['pic'] = $info->getSaveName();
        }


        if ($data['birthday'] == "") {
            unset($data['birthday']);
        }
        model('Student')->save($data, ['id' => input('post.id')]);

        return apiReturn(1, 'OK');
    }
    public function hello() {
        return 'ka';
    }

    public function delete() {
        if (!request()->isPost()) {
            return 'hi';
        }

        model('Student')->where('id', input('post.id'))->delete();
        return apiReturn(1, 'OK');
    }

}
