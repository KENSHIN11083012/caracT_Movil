import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PhotoCaptureField extends StatefulWidget {
  final String label;
  final String? imagePath;
  final void Function(String?) onImageSelected;
  final String? hintText;
  final bool required;

  const PhotoCaptureField({
    super.key,
    required this.label,
    this.imagePath,
    required this.onImageSelected,
    this.hintText,
    this.required = false,
  });

  @override
  State<PhotoCaptureField> createState() => _PhotoCaptureFieldState();
}

class _PhotoCaptureFieldState extends State<PhotoCaptureField> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );
      
      if (image != null) {
        widget.onImageSelected(image.path);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al capturar la foto: $e'),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
          ),
        );
      }
    }
  }  Future<void> _pickFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );
      
      if (image != null) {
        widget.onImageSelected(image.path);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al seleccionar la foto: $e'),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
          ),
        );
      }
    }
  }
  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.photo_camera,
                  color: Color(0xFF4CAF50),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Seleccionar imagen',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildImageSourceOption(
                icon: Icons.camera_alt,
                title: 'Tomar foto',
                subtitle: 'Usar la cámara del dispositivo',
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage();
                },
              ),
              const SizedBox(height: 12),
              _buildImageSourceOption(
                icon: Icons.photo_library,
                title: 'Seleccionar de galería',
                subtitle: 'Elegir una foto existente',
                onTap: () {
                  Navigator.of(context).pop();
                  _pickFromGallery();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageSourceOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF4CAF50),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Row(
              children: [
                Text(
                  widget.label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF424242),
                  ),
                ),
                if (widget.required) ...[
                  const SizedBox(width: 4),
                  const Text(
                    '*',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {              return Container(
                width: double.infinity,
                height: 140, // Reducido de 180 a 140
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: widget.imagePath != null
                        ? const Color(0xFF4CAF50)
                        : Colors.grey.shade300,
                    width: widget.imagePath != null ? 2 : 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      offset: const Offset(0, 2),
                      blurRadius: 8,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: widget.imagePath != null && widget.imagePath!.isNotEmpty
                      ? _buildImagePreview()
                      : _buildImagePlaceholder(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildImagePreview() {
    return Stack(
      children: [
        // Imagen
        Image.file(
          File(widget.imagePath!),
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        
        // Overlay con gradiente
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.3),
                Colors.transparent,
                Colors.transparent,
                Colors.black.withValues(alpha: 0.5),
              ],
            ),
          ),
        ),
        
        // Botones de acción
        Positioned(
          top: 12,
          right: 12,
          child: Row(
            children: [
              _buildActionButton(
                icon: Icons.edit,
                onPressed: _showImageSourceDialog,
                backgroundColor: const Color(0xFF4CAF50),
              ),
              const SizedBox(width: 8),
              _buildActionButton(
                icon: Icons.delete,
                onPressed: () => widget.onImageSelected(null),
                backgroundColor: Colors.red.shade500,
              ),
            ],
          ),
        ),
        
        // Información de la imagen
        Positioned(
          bottom: 12,
          left: 12,
          right: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Imagen seleccionada',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.photo,
                  color: Colors.white.withValues(alpha: 0.8),
                  size: 14,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImagePlaceholder() {
    return Material(
      color: Colors.grey.shade50,
      child: InkWell(
        onTap: _showImageSourceDialog,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.grey.shade50,
                Colors.grey.shade100,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add_a_photo,
                  size: 40,
                  color: Color(0xFF4CAF50),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Agregar imagen',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF424242),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.hintText ?? 'Toca para seleccionar una imagen',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF4CAF50)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.camera_alt,
                      size: 16,
                      color: Color(0xFF4CAF50),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Seleccionar',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4CAF50),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onPressed,
    required Color backgroundColor,
  }) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            color: Colors.white,
            size: 18,
          ),
        ),
      ),
    );
  }
}
