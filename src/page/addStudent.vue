<template>
  <div>
    <head-top></head-top>
  <div style="margin-top: 20px;">
<el-form ref="form" :model="form" :rules="rules" label-width="80px">
  <el-form-item label="名字" prop="name">
    <el-input v-model="form.name"></el-input>
  </el-form-item>
  <el-form-item label="学号" prop="stuid">
    <el-input v-model="form.stuid"></el-input>
  </el-form-item>
  <el-form-item label="学院" prop="college">
    <el-input v-model="form.college"></el-input>
  </el-form-item>
  <el-form-item label="专业" prop="major">
    <el-input v-model="form.major"></el-input>
  </el-form-item>
  <el-form-item label="班级" prop="class">
    <el-input v-model="form.class"></el-input>
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
        form: {
          name: '',
          stuid: '',
          college: '',
          major: '',
          class: '',

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
          college: [
            {required: true, message: '请输入学院', trigger: 'blur'},
          ],
          major: [
            {required: true, message: '请输入专业', trigger: 'blur'},
          ],
          class: [
            {required: true, message: '请输入班级', trigger: 'blur'},
          ],
        },
      }
    },
    methods: {
      async onSubmit() {
        this.$refs['form'].validate(valid => {
          if (valid) {
            this.formData.append('name', this.form.name);
            this.formData.append('stuid', this.form.stuid);
            this.formData.append('college', this.form.college);
            this.formData.append('major', this.form.major);
            this.formData.append('class', this.form.class);
            axios.post(base.url + '/index/student/add', this.formData).then(response => {
              console.log(response);
              if (response['data']['code'] == -1) {
                if (response['data']['msg'] == 'stuid_exists') {
                  this.$alert('学号已存在', '失败', {
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
