package kr.co.tj.image;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ImageFileServiceImpl implements ImageFileService {

	@Autowired
	private ImageFileRepository imageFileRepository;

	@Override
	public ImageFileDTO UploadImage(ImageFileDTO dto) {
		
		ImageFileEntity entity = ImageFileEntity.builder()
		.filedata(dto.getFiledata())
		.filename(dto.getFilename())
		.build();
		
		entity = imageFileRepository.save(entity);
		
		dto.setId(entity.getId());
		
		return dto;
	}

	@Override
	public ImageFileDTO GetImageFile(Long id) {
		Optional<ImageFileEntity> optional = imageFileRepository.findById(id);
		
		if(!optional.isPresent()) {
			throw new RuntimeException();
		}
		ImageFileEntity entity = optional.get();
		ImageFileDTO dto = new ImageFileDTO(entity.getId(), entity.getFilename(), entity.getFiledata());
		return dto;
	}
	
	
}
