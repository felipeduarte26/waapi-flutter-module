import 'package:senior_platform_authentication/senior_platform_authentication.dart';

import 'token_mock.dart';

const mfaInfoConfiguredMock = MFAInfo(
  temporaryToken: 'temporaryToken',
  mfaStatus: 'CONFIGURED',
  tenant: 'tenant',
);

const mfaInfoUnconfiguredMock = MFAInfo(
  temporaryToken: 'temporaryToken',
  mfaStatus: 'UNCONFIGURED',
  tenant: 'tenant',
);

const LoginMFA loginMFAMock = LoginMFA(
  validationCode: '112233',
  temporaryToken:
      'Dr9BFR82r1W7VKbEikNfmJ3Ch0a+U/YXToC/OdkriM6R2LyRxrLyvBz5aypBMVfqd3ek7Jjz5EdCbdHYo5p2g2GJalzFFvVkNxiLBfIBTseYZa69wyZLxA==',
  tenant: 'apphcmcom',
);

final mfaInfoNotConfiguredMock = mfaInfoConfiguredMock.copyWith(
  mfaStatus: '',
);

const authenticationResponseMfaConfiguredMock = AuthenticationResponse(
  mfaInfo: mfaInfoConfiguredMock,
  token: tokenMock,
);

final authenticationResponseMfaNotConfiguredMock = AuthenticationResponse(
  mfaInfo: mfaInfoNotConfiguredMock,
);

const sendMFAConfigEmailMock =
    SendMFAConfigEmail(temporaryToken: 'temporaryToken', tenant: 'tenant');
