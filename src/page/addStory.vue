<template>
  <div>
    <div>

      <div>
        <head-top></head-top>
      </div>

      <div style="margin-top: 20px;">
        ka
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
  import {getUrlKey, setCookie, getCookie} from "../untils/util";
  export default {
    data() {
      return {
        id: '',
        stuInfo: [],
      }
    },
    activated() {
      this.init();
    },
    components: {
      headTop,
    },
    methods: {
      init: async function() {
        this.id = getUrlKey('id');
        axios.get(base.url + '/index/student/get?id=' + this.id).then(response => {
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
            this.stuInfo = response['data']['data'];
          }
        });
      }
    }
  }
</script>
