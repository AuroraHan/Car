package com.lgr.car;

import com.base.WeChatConfig;
import com.tencentcloudapi.common.Credential;
import com.tencentcloudapi.common.exception.TencentCloudSDKException;
import com.tencentcloudapi.common.profile.ClientProfile;
import com.tencentcloudapi.common.profile.HttpProfile;
import com.tencentcloudapi.ocr.v20181119.models.*;
import com.tencentcloudapi.ocr.v20181119.OcrClient;
import org.apache.log4j.Logger;

public class CarApi {

	private Logger logger = Logger.getLogger(CarApi.class);

	//车牌识别
	public RootResp carVerify(String image) {
		RootResp result = new RootResp();
		try{

			Credential cred = new Credential(WeChatConfig.SECRETID, WeChatConfig.SECRETKEY);

			HttpProfile httpProfile = new HttpProfile();
			httpProfile.setEndpoint(WeChatConfig.SERVERIP);

			ClientProfile clientProfile = new ClientProfile();
			clientProfile.setHttpProfile(httpProfile);
			//车牌识别
			OcrClient ocrclient = new OcrClient(cred,WeChatConfig.AREA,clientProfile);
			LicensePlateOCRRequest req = new LicensePlateOCRRequest();
			req.setImageBase64(image);
			LicensePlateOCRResponse resp = ocrclient.LicensePlateOCR(req);

			System.out.println(LicensePlateOCRResponse.toJsonString(resp));

			result.setData(LicensePlateOCRResponse.toJsonString(resp));
		} catch (TencentCloudSDKException e) {
			result.setRet(-1);
			result.setMsg(e.toString());
			logger.error(e.toString());
		}
		logger.info(result);

		return result;
	}
}
