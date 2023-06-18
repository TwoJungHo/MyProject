package kr.co.tj.image;

public interface ImageFileService {

	ImageFileDTO UploadImage(ImageFileDTO dto);

	ImageFileDTO GetImageFile(Long id);

}
