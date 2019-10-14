echo "start prepare tool"

save_dir=".data"


rm -fr $save_dir 

[ ! -d "$save_dir" ] && mkdir -p "$save_dir" # Now download it

#############
## gdown.pl
#############
if ! [ -x "$(command -v gdrive)" ]; then
  echo 'Error: gdrive is not installed.' >&2
  wget https://github.com/gdrive-org/gdrive/releases/download/2.1.0/gdrive-linux-x64 -P $save_dir
   chmod +x $save_dir/gdrive-linux-x64	
fi

#############
## mnist
#############
echo "get mnist dataset from google driver "
$save_dir/gdrive-linux-x64 download  -r 1NpZhe964aqcW7DbmqVqpiI7RUYoYVpGc  --path $save_dir
tar -xf $save_dir/mnist_data.tar 


#############
## prepare software
# 1, install req.txt
# 2, check python dependence
#############
echo "=== check pytorch"
if python -c "import torch" &> /dev/null; then
    echo 'Succeefull :: pytorch installed'
else
    echo 'uh oh, pls install pytorch '
    exit
fi

echo "=== install dependence"
pip install  -r req.txt

############
##  run cnn
###########

echo "==== train  with CNN "
python run_cnn.py 
echo "finish train ,just epoch 2 "
echo "=== evalute with CNN by pretrained model"


echo "finish .."
