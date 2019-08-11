import axios from '../untils/http'
import QS from 'qs'
import base from './base'

export function addStudent(data) {
  return axios({
    url: `${base.url}/index/student/add`,
    method: 'post',
    data: data,
    headers:{"Content-Type":"multipart/form-data"}

  })
}


