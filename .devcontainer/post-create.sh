if [ -f requirements.txt ]; then
    pip install -r requirements.txt
fi

if [ -f env.yml ]; then
    conda env update --file env.yml
fi
