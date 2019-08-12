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
    },
    components: {
      headTop,
    },
  }
</script>
