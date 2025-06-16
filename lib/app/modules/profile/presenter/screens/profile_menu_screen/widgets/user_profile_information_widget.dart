import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_design_system/senior_design_system.dart';
import 'package:senior_design_tokens/senior_design_tokens.dart';

import '../../../../../../core/extension/translate_extension.dart';
import '../../../../../../core/helper/file_helper.dart';
import '../../../../../authorization/presenter/blocs/authorization_bloc/authorization_state.dart';
import '../../../blocs/person_bloc/person_state.dart';
import '../../../blocs/profile_bloc/profile_event.dart';
import '../../../blocs/profile_bloc/profile_state.dart';
import '../bloc/profile_menu_screen_bloc.dart';
import '../bloc/profile_menu_screen_state.dart';

class UserProfileInformationWidget extends StatefulWidget {
  const UserProfileInformationWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<UserProfileInformationWidget> createState() {
    return _UserProfileInformationWidgetState();
  }
}

class _UserProfileInformationWidgetState extends State<UserProfileInformationWidget> {
  late ProfileMenuScreenBloc _profileMenuScreenBloc;
  bool _enableEditPersonalPhoto = false;

  @override
  void initState() {
    super.initState();
    _profileMenuScreenBloc = Modular.get<ProfileMenuScreenBloc>();

    if (_profileMenuScreenBloc.authorizationBloc.state is LoadedAuthorizationState) {
      _enableEditPersonalPhoto = (_profileMenuScreenBloc.authorizationBloc.state as LoadedAuthorizationState)
          .authorizationEntity
          .enablePersonalPhoto;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeRepository = Provider.of<ThemeRepository>(context);
    return BlocConsumer<ProfileMenuScreenBloc, ProfileMenuScreenState>(
      bloc: _profileMenuScreenBloc,
      listener: (context, state) {
        final profileState = state.profileState;
        if (profileState is ErrorUpdatePhotoProfileState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SeniorSnackBar.error(
              message: context.translate.errorUpdatePhoto,
              action: SeniorSnackBarAction(
                label: context.translate.repeat,
                onPressed: () {
                  _profileMenuScreenBloc.profileBloc.add(
                    UpdatePhotoProfileEvent(
                      base64Image: profileState.base64Image,
                      contentType: 'image/jpeg',
                      userId: profileState.userId,
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        final profileEntity = state.profileState.profileEntity;
        final personState = state.personState;

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: SeniorSpacing.medium,
                    ),
                    child: SeniorProfilePicture(
                      isLoading: _profileMenuScreenBloc.profileBloc.state is UpdatingPhotoProfileState,
                      radius: SeniorCircularElements.medium,
                      name: profileEntity!.name,
                      imageProvider: NetworkImage(
                        _profileMenuScreenBloc.profileBloc.state.urlPhotoProfile ?? profileEntity.linkPhoto,
                      ),
                    ),
                  ),
                  personState is LoadedPersonState
                      ? Material(
                          borderRadius: BorderRadius.circular(SeniorSpacing.xxhuge),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(SeniorSpacing.xxhuge),
                            onTap: () {
                              SeniorImageCropper(
                                cancelButtonLabel: context.translate.optionCancel,
                                doneButtonLabel: context.translate.saveProfilePicture,
                                cropperTitle: context.translate.changeProfilePicture,
                                onPermissionCameraDenied: () => ScaffoldMessenger.of(context).showSnackBar(
                                  SeniorSnackBar.error(
                                    message: context.translate.errorPermissionPhoto,
                                  ),
                                ),
                                onPermissionGalleryDenied: () => ScaffoldMessenger.of(context).showSnackBar(
                                  SeniorSnackBar.error(
                                    message: context.translate.errorPermissionGallery,
                                  ),
                                ),
                                maxSizeMb: 2,
                                onCropImage: (croppedImage) async {
                                  final base64Image = await FileHelper.fileToBase64(
                                    file: croppedImage,
                                  );

                                  _profileMenuScreenBloc.profileBloc.add(
                                    UpdatePhotoProfileEvent(
                                      base64Image: base64Image,
                                      contentType: 'image/jpeg',
                                      userId: personState.personId,
                                    ),
                                  );
                                },
                                pickImageLabel: context.translate.photoGallery,
                                takePhotoLabel: context.translate.takePicture,
                              ).pickImage(context);
                            },
                            child: _enableEditPersonalPhoto
                                ? Padding(
                                    padding: const EdgeInsets.all(SeniorSpacing.xxsmall),
                                    child: SeniorIcon(
                                      icon: FontAwesomeIcons.solidPenToSquare,
                                      style: themeRepository.isCustomTheme()
                                          ? SeniorIconStyle(
                                              color: SeniorServiceColor.getContrastAdjustedColorTheme(
                                                color: themeRepository.theme.primaryColor!,
                                              ),
                                            )
                                          : null,
                                      size: SeniorSpacing.normal,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
              const SizedBox(
                height: SeniorSpacing.xsmall,
              ),
              SeniorText.label(
                profileEntity.name,
              ),
              if (profileEntity.contract?.jobPosition != null)
                SeniorText.small(
                  profileEntity.contract!.jobPosition!,
                ),
            ],
          ),
        );
      },
    );
  }
}
