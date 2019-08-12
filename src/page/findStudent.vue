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

          <el-form-item>
            <el-button type="primary" @click="onSubmit">立即查找</el-button>
          </el-form-item>
        </el-form>
      </div>

      <div>
        <el-table
          :data="tableData"
          border
          style="width: 100%">
          <el-table-column
            fixed
            prop="name"
            label="姓名"
            width="150">
          </el-table-column>
          <el-table-column
            prop="stuid"
            label="学号"
            width="120">
          </el-table-column>
          <el-table-column
            prop="duty"
            label="职务"
            width="120">
          </el-table-column>
          <el-table-column
            prop="place"
            label="籍贯"
            width="120">
          </el-table-column>
          <el-table-column
            prop="idcard"
            label="身份证号"
            width="300">
          </el-table-column>
          <el-table-column
            prop="nation"
            label="民族"
            width="120">
          </el-table-column>
          <el-table-column
            prop="politic"
            label="政治面貌"
            width="120">
          </el-table-column>
          <el-table-column
            prop="birthday"
            label="出生日期"
            width="120">
          </el-table-column>
          <el-table-column
            prop="home"
            label="家庭住址"
            width="120">
          </el-table-column>
          <el-table-column
            prop="contact"
            label="联系方式"
            width="120">
          </el-table-column>
          <el-table-column
            fixed="right"
            label="操作"
            width="150">
            <template slot-scope="scope">
              <el-button @click="handleClick(scope.row)" type="text" size="small">编辑信息</el-button>
              <el-button @click="addStory(scope.row)" type="text" size="small">新增表现</el-button>
              <el-button @click="stories(scope.row)" type="text" size="small">查看表现</el-button>
            </template>
          </el-table-column>
        </el-table>
      </div>
    </div>
  </div>
</template>

<script>

  import axios from 'axios'
  import headTop from '@/components/headTop'
  import { findStudent } from "../untils/student.js";
  import { uploadImgUrl }from '@/config/env';
  import  base  from '@/untils/base';
  export default {
    data() {
      return {
        form: {
          name: '',
          stuid: '',
        },
        formData: new FormData(),
        tableData: [],
      }
    },
    methods: {
      async onSubmit() {
        this.formData.append('name', this.form.name);
        this.formData.append('stuid', this.form.stuid);
        axios.get(base.url + '/index/student/find?page=1&limit=100000000000&name=' + this.form.name + '&stuid=' + this.form.stuid).then(response => {
          console.log(response);
          if (response['data']['code'] == -1) {
            if (response['data']['msg'] == 'no_right') {
              this.$alert('请重新登录', '失败', {
                confirmButtonText: '确定',
              });
            } else {
              this.$alert(response['data']['msg'], '失败', {
                confirmButtonText: '确定',
              });
            }
          } else {
            this.tableData = response['data']['data']['data'];
          }
        });
      },
      handleClick(row) {
        this.$router.push('student?id=' + row['id']);
      },
      stories(row) {
        this.$router.push('stories?stuid=' + row['stuid']);
      },
      addStory(row) {
        // this.$router.push('addStory?id=' + row['id']);
        this.$prompt('请输入学号为'+ row['stuid'] +'的日常表现', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          inputType: 'textarea',
        }).then(({ value }) => {
          let theFormData = new FormData();
          theFormData.append('stuid', row['stuid']);
          theFormData.append('content', value);
          axios.post(base.url + '/index/story/add', theFormData).then(response => {
            console.log(response);
            if (response['data']['code'] == -1) {
              if (response['data']['msg'] == 'no_right') {
                this.$alert('请重新登录', '失败', {
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
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '取消输入'
          });
        });
      }
    },
    components: {
      headTop,
    },
  }
</script>
