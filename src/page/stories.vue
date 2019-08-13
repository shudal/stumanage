<template>
  <div>
    <div>
      <head-top></head-top>
    </div>

    <div style="margin-top: 20px;">

      <div>
        <el-table
          :data="tableData"
          border
          style="width: 100%">
          <el-table-column
            fixed
            prop="stuid"
            label="学号"
            width="100">
          </el-table-column>
          <el-table-column
            prop="create_time"
            label="创建日期"
            width="100">
          </el-table-column>
          <el-table-column
            prop="content"
            label="日常表现"
            width="520">
          </el-table-column>

          <el-table-column
            fixed="right"
            label="操作"
            width="150">
            <template slot-scope="scope">
              <el-button @click="mydelete(scope.row)" type="text" size="small">删除</el-button>
              <el-button @click="modify(scope.row)" type="text" size="small">修改</el-button>
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
  import {getUrlKey, setCookie, getCookie} from "../untils/util";
  export default {
    activated() {
      this.init();
    },
    data() {
      return {
        tableData: [],
        stuid: '',
      }
    },
    methods: {
      init: async function () {
        this.stuid = getUrlKey('stuid');
        axios.get(base.url + '/index/story/get?stuid=' + this.stuid).then(response => {
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
            this.tableData = response['data']['data'];
          }
        });
      },
      mydelete: async function(row) {
        let theFormData = new FormData();
        theFormData.append('id', row['id']);
        axios.post(base.url + '/index/story/delete', theFormData).then(response => {
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
              message: '删除成功',
              type: 'success'
            });
            this.init()
          }
        });
      },
      modify: async function (row) {
        this.stuid = getUrlKey('stuid');
        let theFormData = new FormData();
        theFormData.append('stuid', this.stuid);
        theFormData.append('id', row['id']);
        this.$prompt('请修改日常表现', '修改', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          inputType: 'textarea',
          inputValue: row['content'],
        }).then(({ value }) => {
          let theFormData = new FormData();
          theFormData.append('stuid', row['stuid']);
          theFormData.append('content', value);
          theFormData.append('id', row['id']);
          axios.post(base.url + '/index/story/update', theFormData).then(response => {
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
                message: '修改成功',
                type: 'success'
              });
              this.init();
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
