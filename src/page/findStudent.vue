<template>
  <div>
    <div>
      <head-top></head-top>
    </div>

    <div style="margin-top: 20px;">
      <div>
        <el-form ref="form" :model="form"  label-width="80px">
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

          <el-form-item>
            <el-button type="primary" @click="onSubmit">立即查找</el-button>
            <el-button>取消</el-button>
          </el-form-item>
        </el-form>
      </div>
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
        formData: new FormData(),
      }
    },
    methods: {
      async onSubmit() {
        this.formData.append('name', this.form.name);
        this.formData.append('stuid', this.form.stuid);
        this.formData.append('college', this.form.college);
        this.formData.append('major', this.form.major);
        this.formData.append('class', this.form.class);
        axios.get(base.url + '/index/student/find', this.formData).then(response => {
          console.log(response);
          if (response['data']['code'] == -1) {
            this.$alert(response['data']['msg'], '失败', {
              confirmButtonText: '确定',
            });
          } else {
          }
        });
      },
    }
  }
</script>
