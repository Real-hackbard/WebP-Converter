# :computer: WebP-Converter

</br>

![Compiler](https://github.com/user-attachments/assets/a916143d-3f1b-4e1f-b1e0-1067ef9e0401) ![10 Seattle](https://github.com/user-attachments/assets/c70b7f21-688a-4239-87c9-9a03a8ff25ab) ![10 1 Berlin](https://github.com/user-attachments/assets/bdcd48fc-9f09-4830-b82e-d38c20492362) ![10 2 Tokyo](https://github.com/user-attachments/assets/5bdb9f86-7f44-4f7e-aed2-dd08de170bd5) ![10 3 Rio](https://github.com/user-attachments/assets/e7d09817-54b6-4d71-a373-22ee179cd49c)  ![10 4 Sydney](https://github.com/user-attachments/assets/e75342ca-1e24-4a7e-8fe3-ce22f307d881) ![11 Alexandria](https://github.com/user-attachments/assets/64f150d0-286a-4edd-acab-9f77f92d68ad) ![12 Athens](https://github.com/user-attachments/assets/59700807-6abf-4e6d-9439-5dc70fc0ceca)  
![Components](https://github.com/user-attachments/assets/d6a7a7a4-f10e-4df1-9c4f-b4a1a8db7f0e) <img src="https://github.com/user-attachments/assets/4f4ce205-efb6-4ba6-8955-f24833b5b9f2" />  <img src="https://github.com/user-attachments/assets/9dc616ed-7fce-4fce-9839-5f80002e4d24" />  <img src="https://github.com/user-attachments/assets/13918db1-aa6e-4477-a7de-d3d5358283fa" />  
![Description](https://github.com/user-attachments/assets/dbf330e0-633c-4b31-a0ef-b1edb9ed5aa7) <img src="https://github.com/user-attachments/assets/aabc2ba1-7e1e-4bcc-8692-d84083791ea8" />  
![Last Update](https://github.com/user-attachments/assets/e1d05f21-2a01-4ecf-94f3-b7bdff4d44dd) <img src="https://github.com/user-attachments/assets/16af1c2a-2944-46e9-860f-6cc9fb0680b7" />  
![License](https://github.com/user-attachments/assets/ff71a38b-8813-4a79-8774-09a2f3893b48) ![Freeware](https://github.com/user-attachments/assets/1fea2bbf-b296-4152-badd-e1cdae115c43)  

</br>


WebP is a [raster graphics](https://en.wikipedia.org/wiki/Raster_graphics) file format developed by Google and intended as a replacement for the JPEG, PNG, and GIF file formats on the Web. It supports [image compression](https://en.wikipedia.org/wiki/Image_compression) (both [lossy](https://en.wikipedia.org/wiki/Lossy_compression) and [lossless](https://en.wikipedia.org/wiki/Lossless_compression)), as well as animation and alpha compositing. The sister project for video is called [WebM](https://en.wikipedia.org/wiki/WebM).

Google announced the WebP format in September 2010; the company released the first stable version of its supporting [library](https://en.wikipedia.org/wiki/Library_(computing)) in April 2018. WebP has seen widespread adoption across the Internet in order to reduce image size, with all major browsers currently supporting the format.

### :wrench: Supported Formats:
* Bitmap
* Jpg/Jpeg
* PNG
* GIF

### :wrench: Features:
* Batch processing
* Adjustment of size proportions
* Lossless compression: Up to 26% smaller than comparable PNG files.
* Lossy compression: Approx. 25% to 34% smaller than JPEG files at the same image quality.
* Transparency: Supports an alpha channel for transparency (with both lossless and lossy compression).
* Quality setting
* Color-toning of RGB pixels
* RGB pixel swapping
* Grayscale, Sepia and Negativ calculating
* Comparing file size ratios
* Flexible compression: Supports both lossless and lossy compression.

<br>

<img src="https://github.com/user-attachments/assets/16c5f123-8ae2-4d74-8324-b2d28a9f7422" />

<br>
<br>

WebP's lossy compression algorithm is based on the intra-frame coding of the VP8 video format and the Resource Interchange File Format ([RIFF](https://en.wikipedia.org/wiki/Resource_Interchange_File_Format)) as a [container format](https://en.wikipedia.org/wiki/Container_format). As such, it is a block-based transformation scheme with eight bits of color depth and a [luminance–chrominance](https://en.wikipedia.org/wiki/Y%E2%80%B2UV#Luminance/chrominance_systems_in_general) model with [chroma subsampling](https://en.wikipedia.org/wiki/Chroma_subsampling) by a ratio of 1:2 (YCbCr 4:2:0). Without further content, the mandatory RIFF container has an overhead of only twenty bytes, though it can also hold additional metadata. The side length of WebP images is limited to 16383 pixels.

<br>

# :speech_balloon: Benefits for the Web

* Faster load times: Smaller file sizes reduce data traffic and speed up website loading.
* Better performance: Supported by all major modern web browsers (****Chrome, Firefox, Edge, Safari, SeaMonkey, Pale Moon, GNOME Web, Midori, and Falkon****) as well as image editing software such as Photoshop.

<br>

# :wrench: Coding parameters

| Config command: | Description: |
| :----------- | :----------- |
| quality: Single     | between 0 (smallest file) and 100 (biggest)  |
| target_size: Integer     | if non-zero, set the desired target size in bytes. Takes precedence over the 'compression'    |
| target_PSNR: Single     | if non-zero, specifies the minimal distortion to try to achieve. Takes precedence over target_size.     |
| method: Integer     | Quality/speed trade-off (0=fast, 6=slower-better)     |
| segments: Integer     | Maximum number of segments to use, in [1..4]     |
| sns_strength: Integer     | Spatial Noise Shaping. 0=off, 100=maximum.     |
| filter_strength: Integer     | range: 0 = off .. 100 = strongest     |
| filter_sharpness: Integer     | range: 0 = off .. 7 = least sharp    |
| filter_type: Integer     | filtering type: 0 = simple, 1 = strong (only used if filter_strength > 0 or autofilter > 0)    |
| autofilter: Integer     | Auto adjust filter's strength 0 = off, 1 = on     |
| pass: Integer     | number of entropy-analysis passes (in 1..10).     |
| show_compressed     | If true, export the compressed picture back. In-loop filtering is not applied.    |
| preprocessing: Integer     | Preprocessing filter (0=none, 1=segment-smooth) log2(number of token partitions) in 0..3 Default is set to 0 for easier progressive decoding.   |
