<template>
  <div>
    <head-top></head-top>
  <div style="margin-top: 20px;">
<el-form ref="form" :model="form" :rules="rules" label-width="80px">
  <el-form-item label="姓名" prop="name">
    <el-input v-model="form.name"></el-input>
  </el-form-item>
  <el-form-item label="学号" prop="stuid">
    <el-input v-model="form.stuid"></el-input>
  </el-form-item>
  <el-form-item label="性别" prop="sex">
    <el-select v-model="form.sex" placeholder="请选择">
      <el-option
	v-for="item in options"
	:key="item.value"
	:label="item.label"
	:value="item.value">
      </el-option>
    </el-select>
  </el-form-item>
  <el-form-item label="职务" prop="duty">
    <el-input v-model="form.duty"></el-input>
  </el-form-item>
  <el-form-item label="籍贯" prop="place">
    <el-input v-model="form.place"></el-input>
  </el-form-item>
  <el-form-item label="身份证号" prop="idcard">
    <el-input v-model="form.idcard"></el-input>
  </el-form-item>
  <el-form-item label="民族" prop="nation">
    <el-input v-model="form.nation"></el-input>
  </el-form-item>
  <el-form-item label="政治面貌" prop="politic">
    <el-input v-model="form.politic"></el-input>
  </el-form-item>
  <el-form-item label="出生日期" prop="birthday">
    <div class="block">
      <span class="demonstration"></span>
      <el-date-picker
        v-model="form.birthday"
        type="date"
        placeholder="选择日期"
        value-format="timestamp">
      </el-date-picker>
    </div>
  </el-form-item>
  <el-form-item label="家庭地址" prop="home">
    <el-input v-model="form.home"></el-input>
  </el-form-item>
  <el-form-item label="联系方式" prop="contact">
    <el-input v-model="form.contact"></el-input>
  </el-form-item>
  <el-form-item label="头像" prop="avatar">
    <el-upload
      class="avatar-uploader"
      action="https://jsonplaceholder.typicode.com/posts/"
      :http-request="upload"
      :show-file-list="false"
      :on-success="handleAvatarSuccess"
      :before-upload="beforeAvatarUpload"
      :with-credentials="true" >
      <i v-if="imgNotSelected" class="el-icon-plus avatar-uploader-icon"></i>
      <p v-else> {{ imgFileName }}</p>
    </el-upload>
  </el-form-item>
  <el-form-item>
    <el-button type="primary" @click="onSubmit">立即创建</el-button>
    <el-button>取消</el-button>
  </el-form-item>
</el-form>
  </div>
  </div>
</template>
<script>
  import axios from 'axios'
  import headTop from '@/components/headTop'
  import { addStudent } from "../untils/student.js";
  import { uploadImgUrl }from '@/config/env';
  import  base  from '@/untils/base';

  export default {
    data() {
      return {
	options: [
		{ value: '男', label: '男' },
		{ value: '女', label: '女' }
	],
        form: {
          name: '',
          stuid: '',
	  sex: '',
          duty: '',
          place: '',
          idcard: '',
          nation: '',
          politic: '',
          birthday: '',
          home: '',
          contact: '',
        },
        imageUrl: '',
        uploadImgUrl: uploadImgUrl,
        formData: new FormData(),
        imgNotSelected: true,
        imgFileName: 'this is img file name',
        rules: {
          name: [
            {required: true, message: '请输入名字', trigger: 'blur'},
          ],
          stuid: [
            {required: true, message: '请输入学号', trigger: 'blur'},
          ],
	  sex: [
	    {required: false },
	  ],
	  /*
          duty: [
            {required: true, message: '请输入职务', trigger: 'blur'},
          ],
          place: [
            {required: true, message: '请输入籍贯', trigger: 'blur'},
          ],
          idcard: [
            {required: true, message: '请输入身份证号', trigger: 'blur'},
          ],
          nation: [
            {required: true, message: '请输入民族', trigger: 'blur'},
          ],
          politic: [
            {required: true, message: '请输入政治面貌', trigger: 'blur'},
          ],
          birthday: [
            {required: true, message: '请输入出生日期', trigger: 'blur'},
          ],
          home: [
            {required: true, message: '请输入家庭地址', trigger: 'blur'},
          ],
          contact: [
            {required: true, message: '请输入联系方式', trigger: 'blur'},
          ],
	  */
        },
      }
    },
    methods: {
      async onSubmit() {
        this.$refs['form'].validate(valid => {
          if (valid) {
            this.formData.append('name', this.form.name);
            this.formData.append('stuid', this.form.stuid);
            this.formData.append('duty', this.form.duty);
            this.formData.append('place', this.form.place);
            this.formData.append('idcard', this.form.idcard);
            this.formData.append('nation', this.form.nation);
            this.formData.append('politic', this.form.politic);
            this.formData.append('birthday', this.form.birthday);
            this.formData.append('home', this.form.home);
            this.formData.append('contact', this.form.contact);
            axios.post(base.url + '/index/student/add', this.formData).then(response => {
              console.log(response);
              if (response['data']['code'] == -1) {
                if (response['data']['msg'] == 'stuid_exists') {
                  this.$alert('学号已存在', '失败', {
                    confirmButtonText: '确定',
                  });
                } else if (response['data']['msg'] == 'no_right') {
                  this.$alert('请重新登录', '失败', {
                    confirmButtonText: '确定',
                  });
                } else if (response['data']['msg']) {
                  this.$alert('请选择照片', '失败', {
                    confirmButtonText: '确定',
                  });
                } else {
                  this.$alert(response['data']['msg'], '失败', {
                    confirmButtonText: '确定',
                  });
                }
              } else {
                this.$message({
                  message: '添加成功',
                  type: 'success'
                });
              }
            });
          }
        });

      },
      upload(file) {
        console.log(file);
        this.formData.append('file', file.file);
        this.imgNotSelected = false;
        this.imgFileName = file.file.name;
      },
      handleAvatarSuccess(res, file) {
        this.imageUrl = URL.createObjectURL(file.raw);
      },
      beforeAvatarUpload(file) {
        const isJPG = file.type === 'image/jpeg';
        const isLt2M = file.size / 1024 / 1024 < 2;

        if (!isJPG) {
          this.$message.error('上传头像图片只能是 JPG 格式!');
        }
        if (!isLt2M) {
          this.$message.error('上传头像图片大小不能超过 2MB!');
        }
        return isJPG && isLt2M;
      }
    },
    components: {
      headTop,
    },
  }
</script>
<style>
  .avatar-uploader .el-upload {
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }
  .avatar-uploader .el-upload:hover {
    border-color: #409EFF;
  }
  .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 178px;
    height: 178px;
    line-height: 178px;
    text-align: center;
  }
  .avatar {
    width: 178px;
    height: 178px;
    display: block;
  }
</style>
