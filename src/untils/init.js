import axios from '../untils/http'
import QS from 'qs'
import base from './base'

export function deployContract(data) {
    return axios({
        url: `${base.url}/MainContract/deploy`,
        method: 'post',
        data: QS.stringify(data)
    })
}

export function getMainContractAddress(data) {
    return axios({
        url: `${base.url}/MainContract/MainContractAddress`,
        method: 'get',
        data: QS.stringify(data)
    })
}

export function systemInit(data) {
    return axios({
        url: `${base.url}/init/system`,
        method: 'post',
        data: QS.stringify(data)
    })
}