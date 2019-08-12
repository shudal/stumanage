import axios from '../untils/http'
import QS from 'qs'
import base from './base'

export function findStudent(data) {
  return axios({
    url: `${base.url}/index/student/find?name=`,
    method: 'get',
    data: QS.stringify(data),
  })
}


