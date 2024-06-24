export interface RequestCallback {
  onSuccess(code: number | string, data: any, info: string): void;

  onError(error: any): void;
}