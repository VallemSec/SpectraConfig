FROM projectdiscovery/nuclei:latest

RUN mkdir /custom
COPY ./nuclei-templates /custom/

ENTRYPOINT ["nuclei", "-silent", "-j", "-w", "/custom/cms-detection-workflow.yaml", "-u"]