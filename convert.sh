# Change input and output details

output_path="test" # Output Path (Same will be pushed in main also)
input_url="https://video-downloads.googleusercontent.com/ADGPM2kg3zgIqYZoeJ22MRsJt9fg5yXSauvGYFU4EyCdgq0kRm4pkXgXFi18DAUng7lpMYqUrk7Wv9_IxV8Cm2Mdjv2DoDv9RyHHLRju2JE8pAj-PMvI2YZ2WzVAQO2GCU7SjNbTcTE7xwCwzWaPDhcIor1WKsmOdiEQGQOPHUxkvUbccskzaBkVnF35_pGJkMyrCKxs7qi_z78AKJpp2IrETC3ZMdgJKHLTCKZ_UOkanM6H7ibcnoDjIdhgcTD5mibo6-E_mn89oC7Kxv9EhxObmAtWvfvsovWiD7mvm_okCRNKMRTEvsotNqGjJRJg8QqPn5XO6WWnK7VQ56Sye8frd7rWXz4CUckaxymuh_EHJn57PTwh3862QFcdn3B3WtymrMZpGQpPhdoFx4qURO9hL7qPi4t_OWY63LSYRwmoNDnEfMofHgbnVueW7INu_vQ7teEBIkXndB9NtbBhV9b-fSL2HY0raPMbaGW-D9Z5ACi_g4arRjikqCaMad6Cq1PdSivQas7NHSMC_hPY0OsDQz1IQtoOlwyEM18xyAeqp7qD54LMjn6sNVlwIhgmKxz3XPbRVPMgOvIZ8R9EJzM0HNXY6t_RKo-AtiK-MhFPjP7HYbl9XLhSQLt0_TAeyfa9m9uuySgpMZxw8dhTgg8hUWuuA-9mcfg4uNXHyPUGWvv_Xn5v1M0BSo1p2rPx_G33lv2Sk1qIQkp3dRSMh-CxUEDPTJ2HoL9dkLFGICo35Ij9xfVV4n-cT7FdmTLsxYKzdbKHDtlAfIC6v7wrZCKBKAFWka9j7tlIlnLUjwdyAb9t55Ba5mDpzSOoozO71deizmvfo7W3v59-e20keBHerreAlQef8RJf6l4uLuv7r9FwMA83F_Ql-c6QkG4bKYjRcAVmp8yvjfswekNTlHEBeDyUYqAdB_XB_iaZGY4gBEk_E23lJSPU9VgZLOnh0FisHgqNYVDe3RmKzsWV0ukLMg6MHTBLji10SZqfTMBM_8KCa2J8_sgWKetfHHpB75hlYtBhouDtEgBRTWrFXlGA9yhbSFsDFTBPEMzvzsjsLhkRjQZbHDSw-KBQxnmbKoF_Oik395Sj" # Input direct file url
input_extension="mkv" # Extension of file url



# Change ffmpeg configurations according to yur need (If you don't know, don't touch)

wget --quiet -O video.$input_extension $input_url
mkdir $output_path

ffmpeg -hide_banner -y -i video.$input_extension \
  -vf scale=w=640:h=360:force_original_aspect_ratio=decrease -c:a aac -ar 48000 -c:v h264 -profile:v main -crf 20 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time 4 -hls_playlist_type vod  -b:v 800k -maxrate 856k -bufsize 1200k -b:a 96k -hls_segment_filename $output_path/360p_%03d.ts $output_path/360p.m3u8 \
  -vf scale=w=842:h=480:force_original_aspect_ratio=decrease -c:a aac -ar 48000 -c:v h264 -profile:v main -crf 20 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time 4 -hls_playlist_type vod -b:v 1400k -maxrate 1498k -bufsize 2100k -b:a 128k -hls_segment_filename $output_path/480p_%03d.ts $output_path/480p.m3u8 \
  -vf scale=w=1280:h=720:force_original_aspect_ratio=decrease -c:a aac -ar 48000 -c:v h264 -profile:v main -crf 20 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time 4 -hls_playlist_type vod -b:v 2800k -maxrate 2996k -bufsize 4200k -b:a 128k -hls_segment_filename $output_path/720p_%03d.ts $output_path/720p.m3u8 \
  -vf scale=w=1920:h=1080:force_original_aspect_ratio=decrease -c:a aac -ar 48000 -c:v h264 -profile:v main -crf 20 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time 4 -hls_playlist_type vod -b:v 5000k -maxrate 5350k -bufsize 7500k -b:a 192k -hls_segment_filename $output_path/1080p_%03d.ts $output_path/1080p.m3u8

rm video.$input_extension
cd $output_path

echo '#EXTM3U
#EXT-X-VERSION:3
#EXT-X-STREAM-INF:BANDWIDTH=800000,RESOLUTION=640x360
360p.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1400000,RESOLUTION=842x480
480p.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=2800000,RESOLUTION=1280x720
720p.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=5000000,RESOLUTION=1920x1080
1080p.m3u8' > master.m3u8
