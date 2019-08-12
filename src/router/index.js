import Vue from 'vue'
import Router from 'vue-router'
import HelloWorld from '@/components/HelloWorld'

Vue.use(Router)

const login  			= r => require.ensure([], () => r(require('@/page/login')),    			'login');
const manage 			= r => require.ensure([], () => r(require('@/page/manage')),    		'manage');
const home  			= r => require.ensure([], () => r(require('@/page/home')),    			'home');
const addStudent  = r => require.ensure([], () => r(require('@/page/addStudent')),    			'addStudent');
const findStudent  = r => require.ensure([], () => r(require('@/page/findStudent')),    			'findStudent');
const student  = r => require.ensure([], () => r(require('@/page/student')),    			'student');
const addStory  = r => require.ensure([], () => r(require('@/page/addStory')),    			'addStory');
const stories  = r => require.ensure([], () => r(require('@/page/stories')),    			'stories');
export default new Router({
  routes: [
    {
      path: '/',
      name: 'login',
      component: login
    },
    {
      path: '/manage',
      component: manage,
      name: '',
      children: [
        {path: '', component: home, meta:[]},
        {path: '/addStudent', component: addStudent, meta: ['学籍管理', '添加学生']},
        {path: '/findStudent', component: findStudent, meta: ['学生管理', '查找学生']},
        {path: '/student', component: student, meta: ['学生管理', '编辑学生']},
        {path: '/addStory', component: addStory, meta: ['学生管理', '新增表现']},
        {path: '/stories', component: stories, meta: ['学生管理', '查看表现']},

      ]
    }
  ]
})
